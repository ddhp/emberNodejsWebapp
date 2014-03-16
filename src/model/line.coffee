App.Lines = [{
  id: "facial-tissue-lines"
  name: "Facial Tissue Lines"
  image: "images/facial-tissue-line-1.jpg"
  types: [
    "Automatic Interfolder Transfer"
    "Manual Interfolder Transfer"
  ]
  options: [
    "Emboss Roll"
    "Lamination Unit"
  ]
  machines: ["ch-228-series", "ch-230-series"]
  defaultMachine: "ch-228-series"
},{
  id: "napkin-folders"
  name: "Napkin Folders"
  image: "images/napkin-folders-1.jpg"
  types: [
    "Vacuum / Mechanical"
    "Single / Multi lane"
  ]
  options: [
    "Kraft Paper Bander"
  ]
  machines: ["ch-330-series", "a500-dp", "a500-series"]
  defaultMachine: "ch-330-series"
},{
  id: "hand-towel-lines"
  name: "Hand Towel Lines"
  image: "images/hand-towel-line.jpg"
  types: [
    "V-Fold / Z-Fold"
    "Automatic / Manual Transfer Type"
  ]
  options: [
    "Steel to Steel / Steel to Ruber Emboss Roll"
    "Lamination Unit"
    "Kraft Paper Bander"
    "Log Saw"
  ]
  machines: ["300au-series"]
  defaultMachine: "300au-series"
},{
  id: "log-saw"
  name: "Log Saw"
  # image: "images/hand-towel-line.jpg"
  types: [
    # "V-Fold / Z-Fold"
    # "Automatic / Manual Transfer Type"
  ]
  options: [
    # "Steel to Steel / Steel to Ruber Emboss Roll"
    # "Lamination Unit"
    # "Kraft Paper Bander"
    # "Log Saw"
  ]
  machines: ["ch-705-series"]
  defaultMachine: "ch-705-series"
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
