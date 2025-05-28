/* 
 * Script pour le bouton "Retour en haut" qui apparaît pendant le défilement
 */

document.addEventListener('DOMContentLoaded', function() {    // Créer le bouton dynamiquement
    const backToTop = document.createElement('div');
    backToTop.classList.add('back-to-top');
    backToTop.innerHTML = '↑';
    backToTop.setAttribute('aria-label', 'Retour en haut de la page');
    backToTop.setAttribute('role', 'button');
    backToTop.setAttribute('tabindex', '0');
    document.body.appendChild(backToTop);
    
    // Fonction pour gérer la visibilité du bouton
    window.addEventListener('scroll', function() {
        if (window.scrollY > 300) {
            backToTop.classList.add('visible');
        } else {
            backToTop.classList.remove('visible');
        }
    });
    
    // Fonction pour remonter en haut quand on clique sur le bouton
    backToTop.addEventListener('click', function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
});
