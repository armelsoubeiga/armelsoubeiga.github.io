/* 
 * Script pour améliorer la navigation entre les pages paginées
 */

document.addEventListener('DOMContentLoaded', function() {
    // Store the current page in session storage when clicking pagination links
    const paginationLinks = document.querySelectorAll('.pagination a, .big-nav-button');
    
    paginationLinks.forEach(link => {
        if (!link.classList.contains('disabled')) {
            link.addEventListener('click', function(e) {
                // Sauvegarde l'état de défilement pour la page actuelle
                sessionStorage.setItem('lastPageScroll', window.scrollY);
                
                // Indique qu'on vient de cliquer sur un lien de pagination
                sessionStorage.setItem('comingFromPagination', 'true');
            });
        }
    });
    
    // Si on vient d'utiliser la pagination, ajoute une classe pour l'animation
    if (sessionStorage.getItem('comingFromPagination') === 'true') {
        // Trouve le conteneur de cartes
        const cardsContainer = document.querySelector('.year-posts');
        if (cardsContainer) {
            // Ajoute une animation plus vive
            cardsContainer.style.animation = 'none';
            setTimeout(() => {
                cardsContainer.style.animation = 'fadeIn 0.7s ease-out forwards';
            }, 10);
        }
        
        // Réinitialiser le flag de pagination
        sessionStorage.removeItem('comingFromPagination');
    }
});
