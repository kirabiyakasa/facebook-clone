import { Controller } from 'stimulus'

export default class extends Controller {
  initialize() {
    this.comment = this.element;
    this.commentChain = this.comment.parentElement;

    this.likesDislikes = this.comment.querySelector('.likes-dislikes');
    this.likesDislikesDatasets = this.likesDislikes.dataset;
    this.likeIcon = this.likesDislikes.querySelector('.fa-thumbs-up')
    this.dislikeIcon = this.likesDislikes.querySelector('.fa-thumbs-down')
    this.likeColor = 'blue';
    this.dislikeColor = 'red';
    this.setLikesDislikes()
  };

  submit(event) {
    if(event.key === 'Enter') {
      this.targets.find('submit-button').click()
      event.target.value = '';
    }
  };

  reply() {
    this.atUser()
    this.showReplyForm()
    this.expandReplies()
  };

  atUser() {
    let userContainer = this.comment.querySelector('.comment-user')
    let userName = userContainer.firstElementChild.innerHTML.trim();

    this.targets.find('form-field').value = `@${userName} `;
  };

  expandReplies() {
    let repliesContainer = this.commentChain.querySelector('.replies-container');
    let showRepliesButton = this.commentChain.querySelector('.show-replies');

    if (showRepliesButton) {
      showRepliesButton.remove()
    }

    if (repliesContainer) {
      repliesContainer.style.display = ''
    }
  };

  showReplyForm() {
    let replyForm = this.element.querySelector('.reply-form')
    replyForm.style.display = ''
  };

  setLikesDislikes() {
    this.liked = this.likesDislikesDatasets.liked;
    switch (this.liked) {
      case 'true':
        let likeIcon = this.likesDislikes.querySelector('.fa-thumbs-up');
        likeIcon.style.color = this.likeColor;
        break;
      case 'false':
        let dislikeIcon = this.likesDislikes.querySelector('.fa-thumbs-down');
        dislikeIcon.style.color = this.dislikeColor;
        break;
    }
  };

  like() {
    let likesCount = this.likesDislikes.querySelector('.likes-count');

    if (this.likesDislikesDatasets.liked == 'true') {
      this.removeReaction(likesCount)
    } else {
      this.addLike(likesCount)
    }
  };

  dislike() {
    let dislikesCount = this.likesDislikes.querySelector('.dislikes-count');

    if (this.likesDislikesDatasets.liked == 'false') {
      this.removeReaction(dislikesCount)
    } else {
      this.addDislike(dislikesCount)
    }
  };

  addLike(likesCount) {
    if (this.likesDislikesDatasets.liked == 'false') {
      let dislikesCount = this.likesDislikes.querySelector('.dislikes-count');
      this.removeReaction(dislikesCount)
    }
    this.toggleOffLikesDislikesIcon()
    this.adjustReactionCount(likesCount, +1)
    this.likesDislikesDatasets.liked = 'true';
    this.likeIcon.style.color = this.likeColor;
  };

  addDislike(dislikesCount) {
    if (this.likesDislikesDatasets.liked == 'true') {
      let likesCount = this.likesDislikes.querySelector('.likes-count');
      this.removeReaction(likesCount)
    }
    this.toggleOffLikesDislikesIcon()
    this.adjustReactionCount(dislikesCount, +1)
    this.likesDislikesDatasets.liked = 'false';
    this.dislikeIcon.style.color = this.dislikeColor;
  };

  removeReaction(countElement) {
    this.toggleOffLikesDislikesIcon();
    this.adjustReactionCount(countElement, -1)
    this.likesDislikesDatasets.liked = '';
  };

  adjustReactionCount(countElement, i) {
    countElement.innerHTML = parseInt(countElement.innerHTML) + i
  }

  toggleOffLikesDislikesIcon() {
    [this.likeIcon, this.dislikeIcon].forEach(element => {
      element.style.color = '';
    });
  };

};

// show more replies

// show more comments
