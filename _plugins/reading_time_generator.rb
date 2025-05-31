module ReadingTimeGenerator
  class Generator < Jekyll::Generator
    def generate(site)
      site.posts.docs.each do |post|
        # Calculer le nombre de mots
        words = post.content.split.size
        
        # Obtenir words_per_minute du site config
        words_per_minute = site.config['words_per_minute'] || 200
        
        # Calculer le temps de lecture
        min_read = (words / words_per_minute.to_f).ceil
        min_read = 1 if min_read < 1
        
        # Stocker le temps de lecture en minutes dans les données du post
        post.data['read_time_minutes'] = min_read
      end
    end
  end
end
