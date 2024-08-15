window.addEventListener('message', (event) => {
    if (event.data.type === 'updateTalking') {
    const voiceIndicator = document.getElementById('voice-indicator');
    const micIcon = document.getElementById('mic-icon');
    const radioIcon = document.getElementById('radio-icon');
    
    if (event.data.isTalking || event.data.isUiOpen) {
    voiceIndicator.classList.remove('hidden');
    } else {
    voiceIndicator.classList.add('hidden');
    }
    
    if (event.data.isTalking) {
        voiceIndicator.classList.add('talking');
    } else {
    voiceIndicator.classList.remove('talking');
    }
    
    if (event.data.isRadio) {
    micIcon.style.display = 'none';
    radioIcon.style.display = 'block';
    voiceIndicator.classList.add('radio');
    } else {
    micIcon.style.display = 'block';
    radioIcon.style.display = 'none';
    voiceIndicator.classList.remove('radio');
    }
    }
    });