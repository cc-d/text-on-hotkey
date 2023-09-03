document.addEventListener("keydown", (event) => {
  console.log("keydown", event.code);
  if (event.altKey && event.shiftKey && event.code === "KeyT") {
    const activeElement: any = document.activeElement;
    if (
      activeElement &&
      (activeElement.tagName === "INPUT" ||
        activeElement.tagName === "TEXTAREA") &&
      (activeElement?.value !== null &&
      activeElement?.value !== undefined)
    ) {
      activeElement.value += "Auto-entered text";
    }
  }
});
