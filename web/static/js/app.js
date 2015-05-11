import {Socket} from "phoenix"

let chatInput         = $("#chat-input")
let messagesContainer = $("#messages")

let socket = new Socket("ws://ruanwz.me:4000/ws")

socket.connect()
socket.join("rooms:lobby", {}).receive("ok", chan => {
  console.log("Welcome to Phoenix Chat!")

  chatInput.off("keypress").on("keypress", event => {
    if(event.keyCode === 13){
      chan.push("new_msg", {body: chatInput.val()})
      chatInput.val("")
    }
  })

  chan.on("new_msg", payload => {
    messagesContainer.append(`<br/>[${Date()}] ${payload.body}`)
  })
})
let App = {
}

export default App