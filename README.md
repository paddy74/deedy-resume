# Deedy-Resume (v2.x)

A **one-page**, **two asymmetric column** resume template in **XeTeX** that caters particularly to an **undergraduate Computer Science** student.
As of **v1.3**, a single template is offered that uses free, clean fonts - *Lato* (and its various variants) and *Raleway*.

It is licensed under the Apache License 2.0.

## Motivation

This fork of the [Deedy-Resume by Deedy](https://github.com/Deedy/Deedy-Resume) was inspired by feedback from /r/resumes and my university career center.  The fonts are a bit heavier and the columns have been reversed to highlight experience first when read in a "Z" pattern.

## Preview

![alt tag](https://raw.githubusercontent.com/paddy74/deedy-resume/master/sample.png)

## Dependencies

Compiles only with **XeTeX** and required **BibTex** for compiling publications and the .bib filetype.

## Availability

- Just clone this repo or download the fonts folder and the .xtx, .sty, and .bib files.
<!--
2. **Overleaf**.com (formerly **WriteLatex**.com) (v1 fonts/colors changed) - [compilable online](https://www.writelatex.com/templates/deedy-resume/sqdbztjjghvz#.U2H9Kq1dV18)
-->

## Known Issues

- Overflows onto second page if any column's contents are more than the vertical limit
- Hacky space on the first bullet point on the second column.

## Developer Guide

- **LaTeX Distribution**: [TeX Live](https://www.tug.org/texlive/)
- **Formatter**: [tex-fmt](https://github.com/WGUNDERWOOD/tex-fmt)
- **Pre-Commit Hooks**: [prek](https://prek.j178.dev/)

```bash
sudo apt install texlive
cargo install tex-fmt
```

## License

> Original Work Copyright 2014 Debarghya Das
> Modified Work Copyright 2018 Zachary Taylor
> Modified Work Copyright 2025 Patrick Young
>
> Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
> You may obtain a copy of the License at
>
> <http://www.apache.org/licenses/LICENSE-2.0>
>
> Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
