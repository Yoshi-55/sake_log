// いいねボタンのアニメーション用
// ページ内の全てのlikeボタンにアニメーションを付与


function bindLikeAnimation() {
  document.querySelectorAll('form[action*="like"]').forEach(function(form) {
    if (form.dataset.animBound) return;
    form.dataset.animBound = true;
    form.addEventListener('submit', function(e) {
      const btn = form.querySelector('button[type="submit"]');
      if (btn) {
        btn.classList.remove('like-animate'); // 連打時のため一度消す
        void btn.offsetWidth; // reflow
        btn.classList.add('like-animate');
      }
    });
  });
}

document.addEventListener('DOMContentLoaded', bindLikeAnimation);
document.addEventListener('turbo:load', bindLikeAnimation);
