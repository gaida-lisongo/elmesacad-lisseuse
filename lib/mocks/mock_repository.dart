import '../models/models.dart';

/// Données factices : utilisateur, 3 catégories, 2 documents (≥ 5 pages chacun).
class MockRepository {
  MockRepository._();

  static final DateTime _t0 = DateTime.utc(2025, 3, 12, 10, 30);

  static User get mockUser => User(
        id: 'usr_7f3c9a2b1e84d506',
        matricule: 'ELM-20488',
        mail: 'lecteur@elmes.example',
        credits: 120.0,
        recharges: [
          Recharge(
            id: 'rch_a001',
            status: 'completed',
            credits: 50,
            orderNumber: 'ORD-900321',
            createdAt: _t0.subtract(const Duration(days: 14)),
            updatedAt: _t0.subtract(const Duration(days: 14, hours: -1)),
          ),
          Recharge(
            id: 'rch_a002',
            status: 'paid',
            credits: 70,
            orderNumber: 'ORD-900410',
            createdAt: _t0.subtract(const Duration(days: 2)),
            updatedAt: _t0.subtract(const Duration(days: 2, minutes: 12)),
          ),
        ],
        metrics: const Metrics(
          categories: 3,
          documents: 2,
          pages: 12,
        ),
      );

  static List<Categorie> get mockCategories => const [
        Categorie(
          id: 'cat_romans',
          reference: 'ROM-001',
          designation: 'Romans & littérature',
          tags: ['fiction', 'classique'],
        ),
        Categorie(
          id: 'cat_essais',
          reference: 'ESS-014',
          designation: 'Essais & société',
          tags: ['essai', 'contemporain'],
        ),
        Categorie(
          id: 'cat_beaux_arts',
          reference: 'ART-203',
          designation: 'Beaux-arts & architecture',
          tags: ['photo', 'patrimoine'],
        ),
      ];

  static String _pic(int seed) =>
      'https://picsum.photos/seed/$seed/400/600';

  static List<Document> get mockDocuments => [
        Document(
          id: 'doc_bridge_notes',
          reference: 'DOC-BRG-01',
          userId: mockUser.id,
          categorieId: 'cat_beaux_arts',
          totalPages: 6,
          title: 'Sous les ponts — carnet visuel',
          description: const [
            DocDescriptionBlock(
              title: 'Résumé',
              content: [
                'Exploration graphique des structures métalliques et de la lumière diffuse.',
              ],
            ),
          ],
          author: Author(
            name: 'Mara Chen',
            email: 'mara.chen@example.com',
            photo: _pic(901),
            description: const [
              AuthorBioSection(
                title: 'À propos',
                content: [
                  'Photographe urbaine, travaille sur le rapport entre ouvrages d’art et mémoire locale.',
                ],
              ),
            ],
          ),
          pages: [
            DocumentPage(
              url: _pic(10101),
              comment: 'Charpente — contre-plongée',
              index: 0,
              isRead: true,
            ),
            DocumentPage(
              url: _pic(10102),
              comment: 'Jonction des poutres',
              index: 1,
              isRead: true,
            ),
            DocumentPage(
              url: _pic(10103),
              comment: 'Maçonnerie en contrebas',
              index: 2,
              isRead: false,
            ),
            DocumentPage(
              url: _pic(10104),
              comment: 'Détail rivets',
              index: 3,
              isRead: false,
            ),
            DocumentPage(
              url: _pic(10105),
              comment: 'Perspective verticale',
              index: 4,
              isRead: false,
            ),
            DocumentPage(
              url: _pic(10106),
              comment: 'Sortie de zone — fin de chapitre',
              index: 5,
              isRead: false,
            ),
          ],
          createdAt: _t0.subtract(const Duration(days: 30)),
          updatedAt: _t0.subtract(const Duration(days: 1)),
        ),
        Document(
          id: 'doc_atlas_letters',
          reference: 'DOC-ATL-07',
          userId: mockUser.id,
          categorieId: 'cat_romans',
          totalPages: 6,
          title: 'Atlas des lettres perdues',
          description: const [
            DocDescriptionBlock(
              title: 'Note éditoriale',
              content: [
                'Recueil fictif de correspondances illustrées ; pages livrées en fac-similés numériques.',
              ],
            ),
          ],
          author: Author(
            name: 'Julien Morel',
            email: 'julien.morel@example.com',
            description: const [
              AuthorBioSection(
                title: 'Bio',
                content: [
                  'Romancier et cartographe imaginaire.',
                ],
              ),
            ],
          ),
          pages: [
            DocumentPage(
              url: _pic(20201),
              comment: 'Lettre I — en-tête',
              index: 0,
              isRead: false,
            ),
            DocumentPage(
              url: _pic(20202),
              comment: 'Corps du texte',
              index: 1,
              isRead: false,
            ),
            DocumentPage(
              url: _pic(20203),
              comment: 'Carte marginale',
              index: 2,
              isRead: false,
            ),
            DocumentPage(
              url: _pic(20204),
              comment: 'Cachet postal',
              index: 3,
              isRead: false,
            ),
            DocumentPage(
              url: _pic(20205),
              comment: 'Verso manuscrit',
              index: 4,
              isRead: false,
            ),
            DocumentPage(
              url: _pic(20206),
              comment: 'Envoi final',
              index: 5,
              isRead: false,
            ),
          ],
          createdAt: _t0.subtract(const Duration(days: 90)),
          updatedAt: _t0.subtract(const Duration(days: 5)),
        ),
      ];

  /// Documents indexés par id de catégorie (la catégorie `cat_essais` est vide volontairement).
  static Map<String, List<Document>> documentsByCategoryId() {
    final map = <String, List<Document>>{};
    for (final c in mockCategories) {
      map[c.id] = [];
    }
    for (final d in mockDocuments) {
      final key = d.categorieId;
      if (key != null && map.containsKey(key)) {
        map[key]!.add(d);
      }
    }
    return map;
  }

  static Document? documentById(String id) {
    for (final d in mockDocuments) {
      if (d.id == id) return d;
    }
    return null;
  }
}
