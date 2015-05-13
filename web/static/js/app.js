import {Socket} from "phoenix"

let chatInput         = $("#chat-input")
let messagesContainer = $("#messages")

//let socket = new Socket("ws://ruanwz.me:4000/ws")
let socket = new Socket("/ws")

socket.connect()
socket.join("groups:1", {"token": "abc"}).receive("ok", chan => {
  console.log("Welcome to Chat!")

  chatInput.off("keypress").on("keypress", event => {
    if(event.keyCode === 13){
      chan.push("new_msg", {data: 
        {
          content: chatInput.val(),
          kind: 'text',
          group_id: 1,
          user_info: {
            user_id: 1,
            nickname: 'david',
            avatar_url: 'http://abc.com/abc.png'
          }
        }
      })
      chatInput.val("")
    }
  })

  chan.on("new_msg", payload => {
    messagesContainer.append(`<br/>[${Date()}] ${payload.data.user_info.nickname} says: ${payload.data.content}`)
  })
})
let App = {
}

export default App
