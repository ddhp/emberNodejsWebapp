App.Lines = [{
  id: "facial-tissue-lines"
  name: "Facial Tissue Lines"
  image: "images/facial-tissue-line-1.jpg"
  features: [
    "Automatic Transfer Type"
    "Emboss Roll"
    "Lamination Unit"
  ]
  machines: ["ch-228-series", "ch-230-series"]
  defaultMachine: "ch-228-series"
},{
  id: "napkin-folders"
  name: "Napkin Folders"
  image: "images/napkin-folders-1.jpg"
  features: [
    "Vacuum Type"
    "Multi-lane"
    "Kraft Paper Bander"
  ]
  machines: ["ch-330-series", "a500-dp", "a500-series"]
  defaultMachine: "ch-330-series"
},{
  id: "hand-towel-lines"
  name: "Hand Towel Lines"
  image: "images/hand-towel-line.jpg"
  features: [
    "Automatic Transfer Type"
    "Emboss Roll"
    "Lamination Unit"
  ]
  machines: ["300au-series"]
  defaultMachine: "300au-series"
}]

# materialize model line by getting machine instance of each item in machines
App.Lines.forEach((line)->
  machineObjs = []
  line.machines.forEach((machineId)->
    machineObjs.push(App.Machines.find((machine)->
      return machine if machine.id is machineId
    ))
  )
  line.machines = machineObjs
)
