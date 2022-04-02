import Rails from '@rails/ujs';
import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['entries', 'pagination'];

  initialize() {
    this.requestCount = 0;
  };

  scroll() {
    let next_page = this.paginationTarget.querySelector('a[rel="next"]')
    if (next_page == null) { return }

    let url = next_page.href

    var body = document.body,
        html = document.documentElement;

    var height = Math.max(body.scrollHeight, body.offsetHeight,
                          html.clientHeight, html.scrollHeight,
                          html.offsetHeight);

    if (Math.ceil(window.pageYOffset) >= (height - window.innerHeight) - 200) {
      this.loadMore(url)
    }
  };

  loadMore(url) {
    if (this.requestCount == 0) {
      this.requestCount += 1;
      Rails.ajax({
        type: 'GET',
        url: url,
        dataType: 'json',
        success: (data) => {
          this.entriesTarget.insertAdjacentHTML('beforeend', data.entries);
          this.paginationTarget.innerHTML = data.pagination;
          setTimeout(() => {
            this.requestCount = 0;
          }, 50)
        }
      })
    }
  };
};
