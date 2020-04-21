
window.onload = () => {
  console.log($('select'));
  $('select').on('change', (event) =>{  
    event.target.previousElementSibling.src = event.target.value
  })
}

