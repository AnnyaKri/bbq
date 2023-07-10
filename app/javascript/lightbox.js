import Lightbox from 'bs5-lightbox';

document.querySelectorAll(".my-lightbox-toggle").forEach((el) => el.addEventListener("click", (e) => {
    e.preventDefault();
    const lightbox = new Lightbox(el, options);
    lightbox.show();
}));
