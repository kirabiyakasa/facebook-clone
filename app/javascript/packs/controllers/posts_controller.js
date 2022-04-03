import Rails from '@rails/ujs';
import CommentsController from './comments_controller';

export default class extends CommentsController {
  static targets = ['commentSection', 'commentsPagination']

  initialize() {
    this.post = this.element

    this.likesDislikes = this.post.querySelector('.likes-dislikes');
    this.likesDislikesDatasets = this.likesDislikes.dataset;
    this.likeIcon = this.likesDislikes.querySelector('.fa-thumbs-up')
    this.dislikeIcon = this.likesDislikes.querySelector('.fa-thumbs-down')
    this.likeColor = 'blue';
    this.dislikeColor = 'red';
    this.setLikesDislikes()

    this.firstComment = this.post.querySelector('.comment')
    if (this.firstComment) {
      this.commentChain = this.firstComment.parentElement
    }
    this.requestCount = 0;
  };

  toggleComments() {
    let commentSection = this.post.querySelector('.comment-section')

    if(commentSection.style.display === 'none') {
      commentSection.style.display = '';
    } else {
      commentSection.style.display = 'none';
    }
  };

  loadMoreComments() {
    let nextPage = this.commentsPaginationTarget.querySelector('a[rel="next"]');
    if (nextPage == null) { return }

    let url = nextPage.href;

    this.getComments(url)
  };

  getComments(url) {
    if (this.requestCount == 0) {
      this.requestCount += 1;
      this.commentSectionTarget.querySelector('.previous-comments-button')
                               .remove()
      Rails.ajax({
        type: 'GET',
        url: url,
        dataType: 'json',
        success: (data) => {
          this.commentSectionTarget.insertAdjacentHTML('afterbegin',
                                                       data.comments)
          this.commentsPaginationTarget.innerHTML = data.commentsPagination;
          setTimeout(() => {
            this.requestCount = 0;
          }, 50)
        }
      })
    }
  };

};
