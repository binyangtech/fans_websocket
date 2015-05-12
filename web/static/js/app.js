import {Socket} from "phoenix"

let chatInput         = $("#chat-input")
let messagesContainer = $("#messages")

//let socket = new Socket("ws://ruanwz.me:4000/ws")
let socket = new Socket("/ws")

socket.connect()
socket.join("rooms:lobby", {"token": "abc"}).receive("ok", chan => {
  console.log("Welcome to Chat!")

  chatInput.off("keypress").on("keypress", event => {
    if(event.keyCode === 13){
      chan.push("new_msg", {data: chatInput.val()})
      chatInput.val("")
    }
  })

  chan.on("new_msg", payload => {
    messagesContainer.append(`<br/>[${Date()}] ${payload.data}`)
  })
})
let App = {
}

export default App
