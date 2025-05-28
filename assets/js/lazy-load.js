/*
 * Script pour optimiser le chargement des images des articles de blog
 * Utilise le lazy loading pour charger les images seulement quand elles sont visibles
 */

document.addEventListener('DOMContentLoaded', function() {
    // Vérifie si le navigateur supporte l'API Intersection Observer
    if ('IntersectionObserver' in window) {
        // Sélectionne toutes les images dans les cartes de blog
        const images = document.querySelectorAll('.post-image img');
        
        // Configuration de l'observer
        const options = {
            root: null, // viewport
            rootMargin: '0px',
            threshold: 0.1 // 10% de l'image visible
        };
        
        // Fonction à appeler quand une image devient visible
        const onIntersection = (entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const image = entry.target;
                    
                    // Charge l'image réelle
                    const src = image.getAttribute('data-src');
                    if (src) {
                        image.src = src;
                    }
                    
                    // Arrête d'observer cette image
                    observer.unobserve(image);
                }
            });
        };
        
        // Crée l'observer
        const observer = new IntersectionObserver(onIntersection, options);
        
        // Observe chaque image
        images.forEach(image => {
            // Stocke le chemin de l'image dans un attribut data-src
            const src = image.src;
            image.setAttribute('data-src', src);
            
            // Utilise une image de placeholder légère
            image.src = 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1 1"%3E%3C/svg%3E';
            
            // Commence à observer l'image
            observer.observe(image);
        });
    }
});
