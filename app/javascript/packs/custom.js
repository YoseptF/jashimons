const tmi = require('tmi.js');

document.addEventListener('turbolinks:load', () => {
  $('select').on('change', (event) => {
    event.target.previousElementSibling.src = event.target.value
  })
  
  const message = $('.message')

  if(message.length){
    mascotPosition = {}
    console.log($('.main-mascot-wrapper img'));
    mascotPosition.width =  $('.main-mascot-wrapper').outerWidth()
    mascotPosition.height =  $('.main-mascot-wrapper').outerWidth()
    console.log(mascotPosition);
    message.css({
      "top": `${mascotPosition.height/6}px`,
      "left": `${mascotPosition.width}px`
    })

    // connect to chat
    const client = new tmi.Client({
      connection: {
        secure: true,
        reconnect: true
      },
      channels: [ 'reinodepruebas' ]
    });
    
    client.connect();
    
    client.on('message', (channel, tags, message, self) => {
      // "Alca: Hello, World!"
      console.log(`${tags['display-name']}: ${message}`);
    });

  }
})

