#import "@preview/fletcher:0.5.8"
#set page(width: auto, height: auto, margin: .5cm)
#set text(font: "Libertinus Sans")


#let list-to-array(it) = {
  if it.has("children") {
    let content = it.children.filter(it => it.func() != list.item)
    if content.any(it => it != [ ]) {
      (content.join(),)
    }

    let items = it.children.filter(it => it.func() == list.item)
    for item in items {
      (list-to-array(item),)
    }
  } else if it.has("body") {
    list-to-array(it.body)
  } else {
    it
  }
}

#let arr = list-to-array[
  - TOP
]

#let spread = 3
#let array-to-nodes(inp, pos: (0, 0)) = {
  import fletcher: edge, node
  import calc: cos, sin
  import fletcher: vector-2d

  // leaf node
  if type(inp) != array {
    return node(pos, inp + [*leaf*])
  }

  // has children
  let angles = range(inp.len()).map(i => i / inp.len() * 360deg)
  for (angle, item) in angles.zip(inp) {
    node(
      (
        pos.at(0) + cos(angle) * spread,
        pos.at(1) + sin(angle) * spread,
      ),
      item.at(0) + [*c*],
    )
    item.slice(1).map(array-to-nodes).join()
  }
}


#let mindmap(array) = fletcher.diagram(debug: 1, spacing: .5em, {
  import fletcher: edge, node
  array-to-nodes(array)
})

#mindmap(arr)

// psuedocode
// 1. place root note (0,0)
// 2. place children "subtree"" i around at rel: (360deg/i, step)
// 3. if subtree has children, handle them as 2.
// 4.
