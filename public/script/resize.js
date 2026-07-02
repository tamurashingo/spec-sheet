(function () {
  document.addEventListener('DOMContentLoaded', function () {
    var handle = document.querySelector('.spec-sheet-resize-handle');
    if (!handle) return;
    var root = document.querySelector('.spec-sheet-root');
    if (!root) return;

    var dragging = false;
    var startX = 0;
    var startWidth = 0;

    handle.addEventListener('mousedown', function (e) {
      dragging = true;
      startX = e.clientX;
      startWidth = parseInt(
        getComputedStyle(root).getPropertyValue('--ss-sidebar-width')
      ) || 240;
      handle.classList.add('spec-sheet-resize-handle--active');
      document.body.style.cursor = 'col-resize';
      document.body.style.userSelect = 'none';
      e.preventDefault();
    });

    document.addEventListener('mousemove', function (e) {
      if (!dragging) return;
      var newWidth = Math.max(160, Math.min(600, startWidth + (e.clientX - startX)));
      root.style.setProperty('--ss-sidebar-width', newWidth + 'px');
    });

    document.addEventListener('mouseup', function () {
      if (!dragging) return;
      dragging = false;
      handle.classList.remove('spec-sheet-resize-handle--active');
      document.body.style.cursor = '';
      document.body.style.userSelect = '';
    });
  });
})();
