const canvas = document.querySelector("canvas");

function signingProcess() { // Begin scoping function
  const signingOptionKeyboard = document.getElementById('keyboard');
  const signingOptionDraw = document.getElementById('draw');
  const signingTextInput = document.getElementById("signature-type-text");
  const pdf = document.getElementById('pdf');

  const contractsPageWrapper = document.querySelector(".contracts-page-wrapper");
  const signaturePadInput = document.querySelector(".signature_pad_input");
  const signButton = document.getElementById("sign-button");
  const signaturePadWrapper = document.querySelector(".signature-pad-wrapper");
  const nextStep = document.querySelector(".next-step");
  const closeButton = document.querySelector("[data-action=close]")
  const wrapper = document.getElementById("signature-pad");
  const clearButton = document.querySelector("[data-action=clear]");
  // const changeColorButton = wrapper.querySelector("[data-action=change-color]");
  const undoButton = document.querySelector("[data-action=undo]");
  const saveSignatureButton = document.querySelector(".save-signature");
  // const saveJPGButton = wrapper.querySelector("[data-action=save-jpg]");
  // const saveSVGButton = wrapper.querySelector("[data-action=save-svg]");
  const signaturePad = new SignaturePad(canvas, {
    // It's Necessary to use an opaque color when saving image as JPEG;
    // this option can be omitted if only saving as PNG or SVG
    backgroundColor: 'rgb(255, 255, 255)'
  });

  function resizeCanvas() {
    // When zoomed out to less than 100%, for some very strange reason,
    // some browsers report devicePixelRatio as less than 1
    // and only part of the canvas is cleared then.
    var ratio =  Math.max(window.devicePixelRatio || 1, 1);

    // This part causes the canvas to be cleared
    canvas.width = canvas.offsetWidth * ratio;
    canvas.height = canvas.offsetHeight * ratio;
    canvas.getContext("2d").scale(ratio, ratio);

    // This library does not listen for canvas changes, so after the canvas is automatically
    // cleared by the browser, SignaturePad#isEmpty might still return false, even though the
    // canvas looks empty, because the internal data of this library wasn't cleared. To make sure
    // that the state of this library is consistent with visual state of the canvas, you
    // have to clear it manually.
    signaturePad.clear();
  }

  function loadSignaturePad() {
    window.onresize = resizeCanvas;
    resizeCanvas();
  }

  function dataURLToBlob(dataURL) {
    // Code taken from https://github.com/ebidel/filer.js
    var parts = dataURL.split(';base64,');
    var contentType = parts[0].split(":")[1];
    var raw = window.atob(parts[1]);
    var rawLength = raw.length;
    var uInt8Array = new Uint8Array(rawLength);

    for (var i = 0; i < rawLength; ++i) {
      uInt8Array[i] = raw.charCodeAt(i);
    }

    return new Blob([uInt8Array], { type: contentType });
  }

  const optionKeyboard = (event) => {
    if (!signingOptionKeyboard.classList.contains("active")) {
      clearButton.classList.add('hidden');
      undoButton.classList.add('hidden');
      signingOptionDraw.classList.remove("active");
      signingOptionDraw.querySelector(".line").classList.add("hidden");
      canvas.classList.add("hidden");

      signingOptionKeyboard.classList.add("active");
      signingOptionKeyboard.querySelector(".line").classList.remove("hidden");
      signingTextInput.classList.remove("hidden");
    }
  }

  const optionDraw = (event) => {
    event.preventDefault();
    if (!signingOptionDraw.classList.contains("active")) {
      clearButton.classList.remove('hidden');
      undoButton.classList.remove('hidden');
      signingOptionKeyboard.classList.remove("active");
      signingOptionKeyboard.querySelector(".line").classList.add("hidden");
      signingTextInput.classList.add("hidden");

      signingOptionDraw.classList.add("active");
      signingOptionDraw.querySelector(".line").classList.remove("hidden");
      canvas.classList.remove("hidden");
      if (canvas.width === 0) {
        resizeCanvas();
      }
    }
  }

  const sign = (event) => {
    event.preventDefault();
    // if (canvas.width === 0) {
    //   resizeCanvas();
    // }
    signaturePadWrapper.classList.remove("hidden");
    contractsPageWrapper.classList.add("opacity");
  }

  const close = (event) => {
    event.preventDefault();
    signaturePadWrapper.classList.add("hidden");
    contractsPageWrapper.classList.remove("opacity");
  }

  const clear = (event) => {
    event.preventDefault();
    signaturePad.clear();
  }

  const undo = (event) => {
    event.preventDefault();
    var data = signaturePad.toData();

    if (data) {
      data.pop(); // remove the last dot or line
      signaturePad.fromData(data);
    }
  }

  const save = (event) => {
    // event.preventDefault();
    if (!signingOptionKeyboard.classList.contains("active")) { //so draw
      if (signaturePad.isEmpty()) {
        alert("Please provide a signature first.");
      } else {
        contractsPageWrapper.classList.remove("opacity");
        signaturePadWrapper.classList.add("hidden");
        // nextStep.classList.remove("hidden");
        // signButton.classList.add("change-position");
        signaturePadInput.value = signaturePad.toDataURL();
      }
    } else { //keyboard
      if (signingTextInput.value === "") {
        alert("Please provide a signature first.");
      } else {
        contractsPageWrapper.classList.remove("opacity");
        signaturePadWrapper.classList.add("hidden");
        // nextStep.classList.remove("hidden");
        // signButton.classList.add("change-position");
        signaturePadInput.value = signingTextInput.value;
      }
    }
  }

  function addAllEventListenersToSign() {
    loadSignaturePad();
    signingOptionKeyboard.addEventListener('click', optionKeyboard);
    signingOptionDraw.addEventListener('click', optionDraw);
    // signButton.addEventListener('click', sign);
    closeButton.addEventListener('click', close);
    clearButton.addEventListener('click', clear);
    undoButton.addEventListener('click', undo);
    saveSignatureButton.addEventListener('click', save);
  };
  if(canvas) {
    addAllEventListenersToSign();
  }
};

function injectSigningProcess() {
  if (canvas) {
    signingProcess();
  }
}


export { injectSigningProcess };
