/* 
 * Ce fichier contient des scripts pour améliorer l'interactivité des cartes de blog
 */

document.addEventListener('DOMContentLoaded', function() {
    // Sélectionne toutes les cartes de blog
    const cards = document.querySelectorAll('.post-card');
    
    // Ajoute des écouteurs d'événements pour chaque carte
    cards.forEach(card => {
        // Effet de mise en évidence au survol
        card.addEventListener('mouseenter', function() {
            this.classList.add('active-card');
        });
        
        card.addEventListener('mouseleave', function() {
            this.classList.remove('active-card');
        });
        
        // Accéder à l'article lors du clic sur toute la carte
        card.addEventListener('click', function(e) {
            // Si le clic n'est pas sur un lien, naviguer vers l'article
            if (!e.target.closest('a')) {
                const link = this.querySelector('.post-title a');
                if (link) {
                    link.click();
                }
            }
        });
    });
    
    // Animation pour les cartes à leur apparition - décalage progressif
    function animateCards() {
        cards.forEach((card, index) => {
            setTimeout(() => {
                card.classList.add('card-visible');
            }, 50 * index); // Réduit le délai entre les cartes
        });
    }
    
    // Lancer l'animation après un court délai pour s'assurer que la page est chargée
    setTimeout(animateCards, 100);
});
