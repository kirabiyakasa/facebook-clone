import CommentsController from './comments_controller'

export default class extends CommentsController {
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
  };

  toggleComments() {
    let commentSection = this.post.querySelector('.comment-section')

    if(commentSection.style.display === 'none') {
      commentSection.style.display = '';
    } else {
      commentSection.style.display = 'none';
    }
  };

};
