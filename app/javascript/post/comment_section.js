document.addEventListener("turbolinks:load", function() {
  loadToggleCommentsEvents()
  loadShowRepliesEvents()
});

function loadToggleCommentsEvents() {
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
};

function loadShowRepliesEvents() {
  repliesPreview = document.querySelectorAll('.show-replies')

  repliesPreview.forEach( preview => {
    preview.addEventListener('click', (event) => {
      let repliesContainer = event.target.parentNode.querySelector(
        '.replies-container');
      event.target.remove()
      if (repliesContainer.style.display == 'none') {
        repliesContainer.style.display = 'block'
      }
    });
  });
};
