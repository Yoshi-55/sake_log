// Ajaxでいいねトグル


function bindLikeAjax() {
  document.querySelectorAll('form[action*="like"]').forEach(function(form) {
    if (form.dataset.ajaxBound) return;
    form.dataset.ajaxBound = true;
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      const btn = form.querySelector('button[type="submit"]');
      if (btn) {
        btn.disabled = true;
      }
      fetch(form.action, {
        method: 'POST',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
          'Accept': 'application/json'
        },
        credentials: 'same-origin',
      })
      .then(res => res.json())
      .then(data => {
        // ハート色・カウント更新
        if (btn) {
          btn.classList.toggle('text-pink-400', data.liked);
          btn.classList.toggle('text-gray-400', !data.liked);
          btn.disabled = false;
        }
        const countSpan = form.querySelector('.like-count');
        if (countSpan) {
          countSpan.textContent = data.count;
        }
      });
    });
  });
}

document.addEventListener('DOMContentLoaded', bindLikeAjax);
document.addEventListener('turbo:load', bindLikeAjax);
