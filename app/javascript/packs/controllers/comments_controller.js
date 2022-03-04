import { Controller } from 'stimulus'

export default class extends Controller {
  initialize() {
    this.comment = this.element
    this.commentChain = this.comment.parentElement
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
    };

    if (repliesContainer) {
      repliesContainer.style.display = ''
    }
  };

  showReplyForm() {
    let replyForm = this.element.querySelector('.reply-form')
    replyForm.style.display = ''
  };
};

// show more replies

// show more comments
