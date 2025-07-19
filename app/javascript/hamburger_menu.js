document.addEventListener('DOMContentLoaded', initializeHamburgerMenu);
document.addEventListener('turbo:load', initializeHamburgerMenu);

function initializeHamburgerMenu() {
  const hamburgerBtn = document.getElementById('hamburger-btn');
  const mainNav = document.getElementById('main-nav');
  
  if (!hamburgerBtn || !mainNav) {
    return;
  }
  
  const newHamburgerBtn = hamburgerBtn.cloneNode(true);
  hamburgerBtn.parentNode.replaceChild(newHamburgerBtn, hamburgerBtn);
  
  newHamburgerBtn.addEventListener('click', function(e) {
    e.preventDefault();
    e.stopPropagation();
    
    const nav = document.getElementById('main-nav');
    if (nav) {
      nav.classList.toggle('hidden');
    }
  });
  
  document.addEventListener('click', function(e) {
    const nav = document.getElementById('main-nav');
    const btn = document.getElementById('hamburger-btn');
    
    if (nav && btn && !nav.contains(e.target) && !btn.contains(e.target)) {
      if (!nav.classList.contains('hidden')) {
        nav.classList.add('hidden');
      }
    }
  });
}
