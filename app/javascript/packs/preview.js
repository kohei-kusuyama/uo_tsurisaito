if (document.URL.match(/new/)){
  document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('post_post_image').addEventListener('change', (e) =>{
      console.log(e);
    });
  });
}