// 设置编号 (引用时, 需要使用标签), 注意, 必须在 heading 设置完成后再调用

#let _set_numbering(body) = {
  let sub-figure-numbering = (super, sub) => numbering("1.1a", counter(heading).get().first(), super, sub)
  let figure-numbering = super => numbering("1-1", counter(heading).get().first(), super)
  let table-numbering = super => numbering("1.1", counter(heading).get().first(), super)
  let equation-numbering = super => numbering("(1-1)", counter(heading).get().first(), super)

  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }
  show figure.caption: it => {
    let pattern = "^[^:]+" + sym.space.nobreak + "[\d.]+"
    show regex(pattern): strong
    show regex(pattern): emph
    // show regex(pattern): set text(weight: "bold")
    // show regex(pattern): set text(style: "italic")
    it
  }

  show figure: set figure(numbering: figure-numbering)
  show figure.where(kind: table): set figure(numbering: table-numbering)
  show math.equation: set math.equation(numbering: equation-numbering)


  body
}
