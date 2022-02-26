document.addEventListener("turbolinks:load", function() {

  let commentsIndicators = document.querySelectorAll('.comments-indicator');

  commentsIndicators.forEach( commentsIndicator => {
    commentsIndicator.addEventListener('click', (event) => {
      let commentSectionId = event.target.dataset.commentsIndicatorId;
      let commentSection = document.querySelector(
        `[data-comment-section-id="${commentSectionId}"`);
      if(commentSection.style.display === 'none') {
        commentSection.style.display = 'block';
      } else {
        commentSection.style.display = 'none';
      }
    });
  });
});
