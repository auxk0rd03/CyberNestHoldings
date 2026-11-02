/**
 * CyberNest Holdings LLC - Frame-Buster / Anti-Clickjacking Defense
 * Guards static HTML pages against UI redress and unauthorized framing (CWE-1021).
 */
(function () {
  if (window.top !== window.self) {
    try {
      if (window.top.location.host !== window.self.location.host) {
        window.top.location = window.self.location;
      }
    } catch (e) {
      // Cross-origin framing detected that blocked top navigation: collapse display
      if (document.documentElement) {
        document.documentElement.style.display = 'none';
      }
    }
  }
})();
