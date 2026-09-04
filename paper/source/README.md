# LaTeX source

This directory contains the original Overleaf project used to write the competition paper.

## Contents

```text
CUMCMThesis-master/
├── cumcm.tex                  Original paper source exported from Overleaf
├── cumcmthesis.cls            Portable public version of the CUMCM class
├── cumcmthesis-original.cls   Unmodified class file from the export
└── figures/                   Figures referenced by the paper
```

The SHA-256 content of `cumcm.tex` is unchanged from the supplied Overleaf export. Only the active `cumcmthesis.cls` was adjusted for portability: when the original SimSun and SimKai font files are absent, it falls back to the Fandol fonts bundled with TeX Live. The original class is retained separately for provenance.

The exported `simkai.ttf` and `simsun.ttc` files are intentionally excluded because they are proprietary system fonts and should not be redistributed through a public repository.

## Compile locally

The class requires XeLaTeX. Run the command from this `source/` directory so the original figure paths continue to resolve:

```bash
xelatex CUMCMThesis-master/cumcm.tex
xelatex CUMCMThesis-master/cumcm.tex
```

The second pass resolves references. A recent TeX Live installation with Chinese-language packages is recommended.

## Compile on Overleaf

1. Upload the complete `CUMCMThesis-master/` directory to a blank Overleaf project.
2. Set `CUMCMThesis-master/cumcm.tex` as the main document.
3. Select XeLaTeX as the compiler.
4. Recompile the project.

The fallback fonts may produce small typographic differences from the submitted PDF. The authoritative competition output remains [`../paper.pdf`](../paper.pdf).
