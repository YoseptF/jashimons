document.addEventListener('turbolinks:load', () => {
  $('select').on('change', (event) => {
    event.target.previousElementSibling.src = event.target.value
  })
})

