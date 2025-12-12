#!/usr/bin/env perl

# Default to a deterministic timezone unless the caller overrides it.
$ENV{'TZ'} //= 'America/New_York';

# Engine selection: allow override via LATEX_ENGINE while defaulting to lualatex.
my $default_engine = 'lualatex';
my %latex_engines = (
  lualatex => 'lualatex',
  pdflatex => 'pdflatex',
  xelatex  => 'xelatex',
);
my $engine = $ENV{'LATEX_ENGINE'} // $default_engine;
$engine = $default_engine unless exists $latex_engines{$engine};

# Consolidate all build artifacts into build/ for reproducible CI runs.
$out_dir = 'build';
$aux_dir = 'build';

$pdf_mode = 1;    # Always produce PDF output.
$pdflatex = sprintf(
  '%s -file-line-error -halt-on-error -synctex=1 %%O %%S',
  $latex_engines{$engine}
);
$latex = $pdflatex;

# Only invoke biber when a .bcf is present; otherwise fall back to bibtex as needed.
$bibtex_use_biber = 2;

# Keep latexmk from spinning on too many passes; fail fast on broken documents.
$max_repeat = 5;

# Auxiliary and modern pdfmanagement outputs to clean with -c / -C.
push @generated_exts, qw(
  acn acr alg aux bbl bcf blg dvi fdb_latexmk fls glg glo gls idx ilg ind
  lof log lol lot run.xml synctex.gz toc xdv xmpi xmpdata
);

# Optional post-build PDF validation for archival/print targets.
# Enable with PDF_VALIDATE=1 and choose a validator via PDF_VALIDATOR=verapdf|gs.
my $should_validate_pdf = $ENV{'PDF_VALIDATE'} // 0;
my $pdf_validator       = $ENV{'PDF_VALIDATOR'} // 'verapdf';

$success_hook = sub {
  return unless $should_validate_pdf;

  my $root = $root_filename // 'main';
  my $pdf  = ($out_dir ? "$out_dir/$root.pdf" : "$root.pdf");
  my $cmd;

  if ($pdf_validator eq 'verapdf' && system('command -v verapdf >/dev/null 2>&1') == 0) {
    $cmd = "verapdf --format text \"$pdf\"";
  }

  if (!$cmd && $pdf_validator eq 'gs' && system('command -v gs >/dev/null 2>&1') == 0) {
    $cmd = "gs -o /dev/null -sDEVICE=pdfwrite -dPDFA=1 -dPDFACompatibilityPolicy=1 -dNOPAUSE -dBATCH \"$pdf\"";
  }

  die "PDF validation requested but no validator found (verapdf or gs)" unless $cmd;
  my $status = system($cmd);
  die "PDF validation failed (cmd: $cmd)" if $status != 0;
};
