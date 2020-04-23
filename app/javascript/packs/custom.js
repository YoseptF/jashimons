const tmi = require('tmi.js');

document.addEventListener('turbolinks:load', () => {
  $('select').on('change', (event) => {
    event.target.previousElementSibling.src = event.target.value
  })

  const message = $('.message')

  //mainMascot show (canvas with mascot to OBS)
  if (message.length) {
    mascotPosition = {}
    mascotPosition.width = $('.main-mascot-wrapper').outerWidth()
    mascotPosition.height = $('.main-mascot-wrapper').outerWidth()
    message.css({
      "top": `${mascotPosition.height / 6}px`,
      "left": `${mascotPosition.width}px`
    })

    //get commands

    const id = window.location.href.split('/')[3]

    fetch(`/commands?id=${id}`)
      .then(response => response.json())
      .then(user_commands => {
        console.log(user_commands);
        
        const mascot = document.querySelector('.main-mascot-wrapper img');

        // connect to chat
        const client = new tmi.Client({
          connection: {
            secure: true,
            reconnect: true
          },
          channels: [user_commands.user.username]
        });

        client.connect();

        client.on('message', (channel, tags, message, self) => {
          const regexed = message.match(/(\![a-zA-Z0-9]*) ?(.*)/);
          if(regexed){
            command = user_commands.configs[regexed[1]]
            if(command){
              console.log(command);
              if (command.message != '') {
                document.querySelector('.message').style.visibility = 'visible'
                document.querySelector('.message').firstElementChild.innerHTML = command.message
                setTimeout(() => {
                  document.querySelector('.message').style.visibility = 'hidden'
                }, parseFloat(command.duration) * 1000)
              }
              if(command.animation_name != ''){
                mascot.src = user_commands.mainAnimation[command.animation_name]
                setTimeout(() => {
                  mascot.src = user_commands.mainAnimation.idle
                }, parseFloat(command.duration) * 1000)
              }
            }
          }

        });
      })

  }

  var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');



  const editForm = (id, datas) => `
  <form action="/commands" accept-charset="UTF-8" method="post">
    <input type="hidden" name="authenticity_token" value=${AUTH_TOKEN}>
    <input type="hidden" name="id" value=${id}>
    <label for="command_name">Trigger</label>
    <input type="text" name="command[name]" id="command_name" value=${datas[0]}>
    <label for="command_message">Message</label>
    <input type="text" name="command[message]" id="command_message" value=${datas[1]}>
    <label for="command_animation_name">Animation Name</label>
    <input type="text" name="command[animation_name]" id="command_animation_name" value=${datas[2]}>

    <label for="command_animation_type">Animation Type</label>
    <select id="command_animation_type" name="command[animation_type]">
      <option value="true" ${datas[3] == 'Infinite' ? 'selected' : ''}>Infinite</option>
      <option value="false" ${datas[3] == 'Finite' ? 'selected' : ''}>Finite</option>
    </select>

    <label for="command_duration">Duration</label>
    <input step="0.5" min="1" max="20" type="number" name="command[duration]" id="command_duration" value=${datas[4]}>
    <label for="command_cooldown">Cooldown</label>
    <input step="0.5" min="0" max="20" type="number" name="command[cooldown]" id="command_cooldown" value=${datas[5]}>
    <label for="command_isEnabled">Enabled</label>
    <input name="command[isEnabled]" type="hidden" value="0">
    <input type="checkbox" value="1" name="command[isEnabled]" id="command_isEnabled" ${datas[6] == 'true' ? 'checked' : ''}>
    <input type="submit" name="commit" value="Save Command" data-disable-with="Save Command">
  </form>
  `
  const newForm = () => `
  <form action="/commands" accept-charset="UTF-8" method="post">
    <input type="hidden" name="authenticity_token" value=${AUTH_TOKEN}>
    <label for="command_name">Trigger</label>
    <input type="text" name="command[name]" id="command_name">
    <label for="command_message">Message</label>
    <input type="text" name="command[message]" id="command_message">
    <label for="command_animation_name">Animation Name</label>
    <input type="text" name="command[animation_name]" id="command_animation_name">
    <label for="command_animation_type">Animation Type</label>
    <input type="text" name="command[animation_type]" id="command_animation_type">
    <label for="command_duration">Duration</label>
    <input step="0.5" min="1" max="20" type="number" name="command[duration]" id="command_duration">
    <label for="command_cooldown">Cooldown</label>
    <input step="0.5" min="1" max="20" type="number" name="command[cooldown]" id="command_cooldown">
    <label for="command_isEnabled">Enabled</label>
    <input name="command[isEnabled]" type="hidden" value="0">
    <input type="checkbox" value="1" name="command[isEnabled]" id="command_isEnabled">
    <input type="submit" name="commit" value="Save Command" data-disable-with="Save Command">
  </form>
  `

  const commandFormWrapper = $('.command-form')

  if (commandFormWrapper.length) {
    $('.editCommandButton').on('click', event => {
      const formData = document.querySelectorAll(`td[data-id="${event.target.dataset.id}"]`)

      const datas = Array.prototype.map.call(formData, data => data.innerHTML)


      commandFormWrapper.html(editForm(event.target.dataset.id, datas))
    })

    $('.addCommand').on('click', () => {
      commandFormWrapper.html(newForm())
    })
  }

})

