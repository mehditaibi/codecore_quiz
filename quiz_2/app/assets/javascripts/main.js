const description = document.querySelectorAll('.description');
const allPlusSign = document.querySelectorAll('.plus-sign');

allPlusSign.forEach(node => {
    node.addEventListener("click", event => {
         console.log(event.currentTarget)
         console.log(event.currentTarget.nextElementSibling.children[1])
         event.currentTarget.nextElementSibling.children[1].classList.toggle('visibility')
    });
});


