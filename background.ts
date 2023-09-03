import { browser } from "webextension-polyfill-ts";

console.log('background.ts loaded')

function enterText() {
  console.log('enterText() called');
  const scriptToExecute = `
    const activeElement = document.activeElement as HTMLInputElement;
    if (activeElement && (activeElement.tagName === 'INPUT' || activeElement.tagName === 'TEXTAREA')) {
      activeElement.value += 'Auto-entered text';
    }
  `;

  browser.tabs.executeScript({
    code: scriptToExecute
  });
}

// Listen for command from manifest.json (Ctrl+Shift+U in this case)
browser.commands.onCommand.addListener((command) => {
  console.log('Command:', command);
  if (command === 'enter-text') {
    enterText();
  }
});

// Test hotkey combination: Alt+Shift+T
document.addEventListener("keydown", (event) => {
  event.preventDefault();  // Prevent the default character from being entered
  if (event.altKey && event.shiftKey && event.code === 'KeyT') {
    enterText();
  }
});
