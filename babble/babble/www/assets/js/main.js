// 'use strict';

document.querySelector("form").onsubmit = (event) => {
  event.preventDefault();
  let selection = document.querySelector("select").selectedIndex;
  console.log(selection);
};


(() => {
  window.addEventListener("load", () => {
    let query_element = document.getElementById("query_text");
    let output_element = document.getElementById("output");

    query_element.value = "";
    output_element.value = "";

    query_element.addEventListener("keyup", (event) => {
      let query_text = event.target.value.trim();

      if(query_text.length > 4) {
        console.log(`Key pressed: ${event.key}`);
        console.log(`Query text: ${query_text}`);
        let query_params = `query: ${encodeURIComponent(query_text)}`;

        fetch(`http://127.0.0.1:9900/?text=${query_params}`)
          .then( response => response.json() )
          .then( response => {
            console.log(response);
            console.log(response.generation);
            response.generation.forEach((res) => {
              console.log(res);
              answers = res['generated_text'].split('event.dataset:smb_mapping | ').at(-1)
              output_element.value = `${answers}\n${output_element.value}`;
            });
          });
      }
    });
  });
})();

void 0;
