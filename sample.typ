#import "@preview/gb7714-bilingual:0.2.3": gb7714-bibliography, init-gb7714, multicite
#import "@preview/lilaq:0.6.0" as lq
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/quill:0.7.2" as quill: tequila as tq

#import "template.typ": project, subpar-grid

#show: project.with(
  anonymous: false,
  title: "狗屁不通文章生成器",
  title2: "但是把标题加长到两行",
  author: "野兽先辈",
  abstract_zh: [
    先帝创业未半而中道崩殂，今天下三分，益州疲弊，此诚危急存亡之秋也。然侍卫之臣不懈于内，忠志之士忘身于外者，盖追先帝之殊遇，欲报之于陛下也。诚宜开张圣听，以光先帝遗德，恢弘志士之气，不宜妄自菲薄，引喻失义，以塞忠谏之路也。

    宫中府中，俱为一体；陟罚臧否，不宜异同。若有作奸犯科及为忠善者，宜付有司论其刑赏，以昭陛下平明之理，不宜偏私，使内外异法也。
  ],
  abstract_en: [
    The founding emperor passed away before his endeavor was half completed, and now the empire is divided into three parts. Yizhou is exhausted and in decline, and this is truly a critical moment of survival or destruction. However, the palace guards are tirelessly serving within, and loyal subjects are sacrificing themselves outside, all in order to repay the late emperor's kindness and show loyalty to the current emperor. It is appropriate to listen to wise advice, to honor the late emperor's virtues, to inspire the courage of loyal subjects, and not to belittle oneself or distort the truth, in order to keep the path of loyal counsel open.

    The palace and government are one entity, and punishments should be consistent. If there are those who commit crimes or show loyalty and virtue, they should be judged by the legal system to demonstrate your fairness as emperor, rather than showing partiality that would create different laws for those inside and outside the palace.
  ],
  keywords_zh: ("关键词1", "关键词2", "关键词3"),
  keywords_en: ("Keyword 1", "Keyword 2", "Keyword 3"),
  school: "复制粘贴写报告学院",
  id: "U114514",
  mentor: "你的老板",
  class: "XXXX 专业 0000 班",
  date: (1919, 8, 10),
  作者声明日期: (1145, 1, 4),
  作者签名图片: image("assets/signature.png", width: 80pt),
)

= 绪论

== typst 介绍

typst 是最新最热的标记文本语言，定位与 LaTeX 类似，具有极强的排版能力，通过一定的语法写文档，然后生成 pdf 文件。与 LaTeX 相比有以下的优势：

+ 编译巨快：因为提供增量编译的功能所以在修改后基本能在一秒内编译出 pdf 文件，typst 提供了监听修改自动编译的功能，可以像 Markdown 一样边写边看效果。

+ 环境搭建简单：原生支持中日韩等非拉丁语言，不用再大量折腾字符兼容问题以及下载好几个 G 的环境。只需要下载命令行程序就能开始编译生成 pdf。

+ 语法友好：对于普通的排版需求，上手难度跟 Markdown 相当，同时文本源码阅读性高：不会再充斥一堆反斜杠跟花括号

个人观点：跟 Markdown 一样好用，跟 LaTeX 一样强大

#figure(
  image("assets/avatar.jpeg", height: 20%),
  caption: "我的 image 实例",
)

== 基本语法

=== 代码执行

正文可以像前面那样直接写出来，隔行相当于分段。

个人理解：typst 有两种环境，代码和内容，在代码的环境中会按代码去执行，在内容环境中会解析成普通的文本，代码环境用{}表示，内容环境用[]表示，在 content 中以 \# 开头来接上一段代码，比如\#set rule，而在花括号包裹的块中调用代码就不需要 \#。

=== 标题

类似 Markdown 里用 \# 表示标题，typst 里用 = 表示标题，一级标题用一个 =，二级标题用两个 =，以此类推。


间距、字体等会自动排版。

\#pagebreak() 函数相当于分页符。论文里第一级标题应当分页，本模板已配置自动分页。

= 本模板相关封装

== 图片

#figure(
  image("assets/avatar.jpeg", height: 20%),
  caption: "我的 image 实例 1",
) <img1>

用 `@img1` 引用 2-1: @img1

#subpar-grid(
  columns: (1fr, 1fr),

  figure(image("assets/avatar.jpeg", height: 20%), caption: [img A]),
  <img-a>,

  figure(image("assets/avatar.jpeg", height: 20%), caption: [img B]),
  <img-b>,

  caption: [需要子图时使用 subpar 包],
  label: <img2>,
)

然后使用 `@img-a` 就可以引用对应的子图 @img-a

== 绘制图片

=== 统计图

#figure(
  [
    #set text(font: "Times New Roman")
    #show: lq.set-diagram(height: 7cm, width: 6cm)
    #show: lq.theme.skyline
    #show: lq.show_(
      lq.tick-label.with(kind: "x"),
      it => box(
        width: 0pt,
        align(right, rotate(-45deg, reflow: true, it)),
      ),
    )

    #lq.diagram(
      xaxis: (
        ticks: ("11111", "2222222", "3333333").enumerate(),
        subticks: none,
      ),
      ylabel: [y],
      lq.bar(
        range(3),
        (5, 4, 1),
        width: 0.4,
      ),
    )
  ],
  caption: [*使用 lilaq 包绘制各种统计图*],
)

具体用法请参考：#link("https://typst.app/universe/package/lilaq/")

=== 流程图

#figure(
  [
    #let bent-edge(from, to, ..args) = {
      let midpoint = (from, 50%, to)
      let vertices = (
        from,
        (from, "|-", midpoint),
        (midpoint, "-|", to),
        to,
      )
      edge(..vertices, "-|>", ..args)
    }

    #diagram(
      node-stroke: luma(80%),
      edge-corner-radius: none,
      spacing: (10pt, 20pt),

      // Nodes
      node((1.5, 0), [*Entrate\ pubblicitarie*], name: <a>),
      node((0.5, 1), [*Numero di\ impression*], name: <b>),
      node((2.5, 1), [*Guadagno medio\ per impression*], name: <c>),

      node((0, 2), [*Traffico\ sul sito*], name: <d>),
      node((1, 2), [*Impression/\ visitatori*], name: <e>),

      node((2, 2), [*Modalità\ di vendita*], name: <f>),
      node((3, 2), [*Tipo di\ posizionamento*], name: <g>),

      // Edges
      bent-edge(<a>, <b>),
      bent-edge(<a>, <c>),
      bent-edge(<b>, <d>),
      bent-edge(<b>, <e>),
      bent-edge(<c>, <f>),
      bent-edge(<c>, <g>),
    )],
  caption: "使用 fletcher 包绘制各种流程图",
)

具体用法请参考：#link("https://typst.app/universe/package/fletcher")

=== 电路图

#figure(
  [
    #quill.quantum-circuit(
      ..tq.build(
        tq.h(0),
        tq.cx(0, 1),
        tq.cx(0, 2),
      ),
      quill.gategroup(x: 2, y: 0, 3, 2),
    )
  ],
  caption: "使用 quill 包绘制各种电路图",
)

具体用法请参考：#link("https://typst.app/universe/package/quill")

== 表格

表格跟图片差不多，但是表格的输入要复杂一点，建议在 typst 官网学习，自由度特别高，定制化很强。

同样使用 figure 函数包裹表格

#figure(
  table(
    columns: 4,
    stroke: none,

    table.hline(),
    table.header([Strategy], [Mode], [Accuracy (24–28◦C)], [Total energy (kWh)]),
    table.hline(stroke: 0.5pt),

    [Default], [N/A], [86.5%], [15837],
    [Rule-based], [LSTM Only], [94.5%], [14214],
    [LLM], [SM+LLM Correct], [97.8%], [12525],

    table.hline(),
  ),
  caption: "三线表示例",
) <三线表示例>

== 公式

公式用两个\$包裹，但是语法跟 LaTeX 并不一样，如果有大量公式需求建议看官网教程 https://typst.app/docs/reference/math/equation/。

不需要封装即可为公式编号

$
  A = pi r^2
$ <eq1>

根据@eq1 ，推断出@eq2

$
  x < y => x gt.eq.not y
$ <eq2>

然后也有多行的如@eq3，标签名字可以自定义

$
  sum_(k=0)^n k & < 1 + ... + n \
                & = (n(n+1)) / 2
$ <eq3>

当然，你也可以使用 #link("https://typst.app/universe/package/mitex/", text("mitex 包"))直接渲染 latex 公式，这在你的公式已经是 latex 格式的情况下（例如 simpletex 识别结果等）很好用。

== 列表

这是无序列表

- 无序列表1: 1
- 无序列表2: 2

这是有序列表

+ 有序列表1
+ 有序列表2

想自己定义可以自己set numbering，建议用 \#[] 包起来保证只在该作用域内生效：

#[
  #set enum(numbering: "1.a)")
  + 自定义列表1
    + 自定义列表1.1
  + 自定义列表2
    + 自定义列表2.1
]

= 其他说明

== 文献引用

引用支持 LaTeX Bib 的格式。在引用时使用 `@tag`，像这样@impagliazzo2001problems 以获得右上的引用标注，需要多引用时，使用 `#multicite[@tag1 @tag2]` #multicite[@刘星2014恶意代码的函数调用图相似性分析 @papadimitriou1998combinatorial]。

== 如果遇到问题怎么办？

去 #link("https://typst-doc-cn.github.io/guide/FAQ.html") 里面找，有绝大多数你会碰到的问题。

== 需要其他的包

去 #link("https://typst.app/universe/") 寻找有用的包。

// 你校不知道为什么会要求参考文献换行后的行头位置超过序号
// 如果有要求就把下面 full-control 这个参数启用
#{
  set par(justify: true, leading: 0.95em, spacing: 0.95em, first-line-indent: 2em)
  gb7714-bibliography(
    // full-control: entries => {
    //   for e in entries [
    //     #set par(first-line-indent: 2em, hanging-indent: 0em)

    //     [#e.order]
    //     #e.labeled-rendered
    //     #parbreak()
    //   ]
    // },
    title: heading(level: 1)[参考文献],
  )
}

#set heading(numbering: "A.1")

#counter(heading).update(1)

= 附录 A <nonumber>

使用 `<nonumber>` 标签将标题设为无编号。在写附录和致谢时很有用。

= 附录 B <nonumber>

这里是附录 B 内容。

= 致谢 <nonumber>

完成本篇论文之际，我要向许多人表达我的感激之情。

首先，我要感谢我的指导教师，他/她对本文提供的宝贵建议和指导。所有这些支持和指导都是无私的，而且让我受益匪浅。

其次，我还要感谢我的家人和朋友们，他们一直以来都是我的支持和鼓励者。他们从未停止鼓舞我，勉励我继续前行，感谢你们一直在我身边，给我幸福和力量。

此外，我还要感谢我的同学们，大家一起度过了很长时间的学习时光，互相支持和鼓励，共同进步。因为有你们的支持，我才能不断地成长、进步。

最后，我想感谢笔者各位，你们的阅读和评价对我非常重要，这也让我意识到了自己写作方面的不足，同时更加明白了自己的研究方向。谢谢大家！

再次向所有支持和鼓励我的人表达我的谢意和感激之情。

本致谢生成自 ChatGPT。

