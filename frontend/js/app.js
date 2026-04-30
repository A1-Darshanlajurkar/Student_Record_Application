// Shared utility used by both pages
function showAlert(message, type) {
    const el = document.getElementById('alert');
    el.textContent  = message;
    el.className    = `alert alert-${type}`;
    el.style.display = 'block';
    setTimeout(() => { el.style.display = 'none'; }, 4000);
}
