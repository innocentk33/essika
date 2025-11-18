import '../../models/category.dart';
import '../../models/service_template.dart';
import '../enum/billing_cycle.dart';

const List<String> categoryImages = [
  'assets/images/category_icons/shopping.png',
  'assets/images/category_icons/food.png',
  'assets/images/category_icons/transportation.png',
  'assets/images/category_icons/entertainment.png',
  'assets/images/category_icons/health.png',
  'assets/images/category_icons/utilities.png',
  'assets/images/category_icons/education.png',
  'assets/images/category_icons/travel.png',
  'assets/images/category_icons/gifts.png',
  'assets/images/category_icons/others.png',
  'assets/images/category_icons/sport.png',
];

const List<String> defaultCategoryNames = [
  'Vêtements',
  'Nourriture',
  'Transport',
  'Divertissement',
  'Santé',
  'Services publics',
  'Éducation',
  'Voyage',
  'Cadeaux',
  'Autres',
  'Sport',
];
final defaultCategories = [
  Category(
    name: 'Vêtements',
    iconName: 'checkroom',
    colorHex: '#E91E63',
    isDefault: true,
  ),
  Category(
    name: 'Nourriture',
    iconName: 'restaurant',
    colorHex: '#FF9800',
    isDefault: true,
  ),
  Category(
    name: 'Transport',
    iconName: 'directions_car',
    colorHex: '#2196F3',
    isDefault: true,
  ),
  Category(
    name: 'Divertissement',
    iconName: 'movie',
    colorHex: '#9C27B0',
    isDefault: true,
  ),
  Category(
    name: 'Santé',
    iconName: 'favorite',
    colorHex: '#F44336',
    isDefault: true,
  ),
  Category(
    name: 'Services publics',
    iconName: 'bolt',
    colorHex: '#FFC107',
    isDefault: true,
  ),
  Category(
    name: 'Éducation',
    iconName: 'school',
    colorHex: '#4CAF50',
    isDefault: true,
  ),
  Category(
    name: 'Voyage',
    iconName: 'flight',
    colorHex: '#00BCD4',
    isDefault: true,
  ),
  Category(
    name: 'Cadeaux',
    iconName: 'card_giftcard',
    colorHex: '#E91E63',
    isDefault: true,
  ),
  Category(
    name: 'Sport',
    iconName: 'fitness_center',
    colorHex: '#FF5722',
    isDefault: true,
  ),
  Category(
    name: 'Autres',
    iconName: 'more_horiz',
    colorHex: '#9E9E9E',
    isDefault: true,
  ),
];
final defaultServices = [
  // Divertissement
  ServiceTemplate(
    name: 'Netflix',
    category: 'Divertissement',
    suggestedPrice: 13.49,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Disney+',
    category: 'Divertissement',
    suggestedPrice: 8.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Amazon Prime Video',
    category: 'Divertissement',
    suggestedPrice: 6.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Canal+',
    category: 'Divertissement',
    suggestedPrice: 22.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'OCS',
    category: 'Divertissement',
    suggestedPrice: 11.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),
  ServiceTemplate(
    name: 'Apple TV+',
    category: 'Divertissement',
    suggestedPrice: 6.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),

  // Musique & Audio
  ServiceTemplate(
    name: 'Spotify',
    category: 'Divertissement',
    suggestedPrice: 10.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Apple Music',
    category: 'Divertissement',
    suggestedPrice: 10.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Deezer',
    category: 'Divertissement',
    suggestedPrice: 10.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),
  ServiceTemplate(
    name: 'YouTube Premium',
    category: 'Divertissement',
    suggestedPrice: 11.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Audible',
    category: 'Divertissement',
    suggestedPrice: 9.95,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),

  // Cloud & Stockage
  ServiceTemplate(
    name: 'iCloud+',
    category: 'Services publics',
    suggestedPrice: 0.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Google One',
    category: 'Services publics',
    suggestedPrice: 1.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Dropbox',
    category: 'Services publics',
    suggestedPrice: 11.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),
  ServiceTemplate(
    name: 'OneDrive',
    category: 'Services publics',
    suggestedPrice: 2.00,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),

  // Sport & Fitness
  ServiceTemplate(
    name: 'Basic-Fit',
    category: 'Sport',
    suggestedPrice: 24.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Keep Cool',
    category: 'Sport',
    suggestedPrice: 29.90,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),
  ServiceTemplate(
    name: 'Nike Training Club',
    category: 'Sport',
    suggestedPrice: 14.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),

  // Éducation & Productivité
  ServiceTemplate(
    name: 'Notion',
    category: 'Éducation',
    suggestedPrice: 8.00,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),
  ServiceTemplate(
    name: 'Duolingo Plus',
    category: 'Éducation',
    suggestedPrice: 6.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),
  ServiceTemplate(
    name: 'LinkedIn Premium',
    category: 'Éducation',
    suggestedPrice: 29.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),
  ServiceTemplate(
    name: 'Babbel',
    category: 'Éducation',
    suggestedPrice: 9.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),

  // Transport
  ServiceTemplate(
    name: 'Navigo (Pass Navigo)',
    category: 'Transport',
    suggestedPrice: 75.20,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Vélib',
    category: 'Transport',
    suggestedPrice: 8.30,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),

  // Presse & Actualités
  ServiceTemplate(
    name: 'Le Monde',
    category: 'Éducation',
    suggestedPrice: 10.00,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),
  ServiceTemplate(
    name: 'Mediapart',
    category: 'Éducation',
    suggestedPrice: 11.00,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),

  // Gaming
  ServiceTemplate(
    name: 'PlayStation Plus',
    category: 'Divertissement',
    suggestedPrice: 8.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Xbox Game Pass',
    category: 'Divertissement',
    suggestedPrice: 12.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Nintendo Switch Online',
    category: 'Divertissement',
    suggestedPrice: 3.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),

  // Services publics
  ServiceTemplate(
    name: 'EDF',
    category: 'Services publics',
    suggestedPrice: 75.00,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'SFR Box',
    category: 'Services publics',
    suggestedPrice: 35.00,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Free Mobile',
    category: 'Services publics',
    suggestedPrice: 19.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Orange',
    category: 'Services publics',
    suggestedPrice: 22.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: true,
  ),
  ServiceTemplate(
    name: 'Bouygues Telecom',
    category: 'Services publics',
    suggestedPrice: 24.99,
    suggestedCycle: BillingCycle.monthly,
    isPopular: false,
  ),
];
