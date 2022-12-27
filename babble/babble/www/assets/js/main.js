

document.querySelector('form').onsubmit = function(e){
  e.preventDefault();

  let selection = document.querySelector('select').selectedIndex;
  console.log(selection);

};

