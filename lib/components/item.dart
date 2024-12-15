import 'package:flutter/material.dart';
import 'package:pks9/model/product.dart';
import 'package:pks9/pages/information.dart';

class ItemNote extends StatelessWidget {
  final Collector collector;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;
  final VoidCallback onEdit; // Добавлен новый колбэк для редактирования
  final bool isActive;

  const ItemNote({
    super.key,
    required this.collector,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.onEdit, // Передача функции редактирования
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CatalogPage(collector: collector)),
      ),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                  child: Image.network(
                    collector.imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          collector.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Цена: ${collector.cost}',
                    style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.info, color: Colors.blue),
                        tooltip: 'Подробнее',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CatalogPage(collector: collector)),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                        tooltip: 'Добавить в избранное',
                        onPressed: onFavoriteToggle,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart, color: Colors.green),
                        tooltip: 'Добавить в корзину',
                        onPressed: isActive ? onAddToCart : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 4,
              left: 4, // Размещаем иконку редактирования в верхнем левом углу
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.deepPurpleAccent),
                tooltip: 'Редактировать',
                onPressed: onEdit, // Вызываем функцию редактирования
              ),
            ),
          ],
        ),
      ),
    );
  }
}
