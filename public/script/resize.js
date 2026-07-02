(function () {
  var dragging = false;
  var startX = 0;
  var startWidth = 0;

  function init(handle) {
    var root = handle.closest('.spec-sheet-root');
    if (!root) return;

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
  }

  function observe() {
    new MutationObserver(function (mutations, observer) {
      for (var i = 0; i < mutations.length; i++) {
        var nodes = mutations[i].addedNodes;
        for (var j = 0; j < nodes.length; j++) {
          var node = nodes[j];
          if (node.nodeType !== 1) continue;
          var handle = node.classList.contains('spec-sheet-resize-handle')
            ? node
            : node.querySelector('.spec-sheet-resize-handle');
          if (handle) {
            init(handle);
            observer.disconnect();
            return;
          }
        }
      }
    }).observe(document.body, { childList: true, subtree: true });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', observe);
  } else {
    observe();
  }
})();
