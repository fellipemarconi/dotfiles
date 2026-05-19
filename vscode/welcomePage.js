(function() {
  var vimLogo = ''
    + '                    .                    \n'
    + '    ##############..... ##############   \n'
    + '    ##############......##############   \n'
    + '      ##########..........##########     \n'
    + '      ##########........##########       \n'
    + '      ##########.......##########        \n'
    + '      ##########.....##########..        \n'
    + '      ##########....##########.....      \n'
    + '    ..##########..##########.........    \n'
    + '  ....##########.#########.............  \n'
    + '    ..################...............    \n'
    + '      ################.............      \n'
    + '      ##############.................    \n'
    + '      ############...................    \n'
    + '      ##########....................     \n'
    + '      ########...................        \n'
    + '      ######    .........                \n'
    + '                  .....                  \n'
    + '                    .                    ';

  function injectLogo() {
    var watermark = document.querySelector('.editor-group-watermark');

    if (!watermark) return false;

    while (watermark.firstChild) {
      watermark.removeChild(watermark.firstChild);
    }

    var pre = document.createElement('pre');

    pre.textContent = vimLogo;

    pre.style.color = '#98c379';
    pre.style.fontFamily = 'JetBrainsMono Nerd Font';
    pre.style.fontSize = '14px';
    pre.style.lineHeight = '1.3';
    pre.style.textAlign = 'center';

    watermark.appendChild(pre);

    return true;
  }

  if (!injectLogo()) {
    var observer = new MutationObserver(function() {
      if (injectLogo()) observer.disconnect();
    });

    observer.observe(document.body, {
      childList: true,
      subtree: true
    });
  }
})();
