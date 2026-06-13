import 'package:flutter/material.dart';

class ServiceModel {
  final String id;
  final String name;
  final String description;
  final String priceLabel;
  final IconData icon;
  final Color color;
  final Color lightColor;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.priceLabel,
    required this.icon,
    required this.color,
    required this.lightColor,
  });
}

final List<ServiceModel> dummyServices = [
 const ServiceModel(
    id: 'plumber',
    name: 'Plumber',
    description:
        'Professional plumbing services for leak repairs, pipe installations, bathroom fittings, water heater setup, and drainage solutions. Our certified plumbers arrive equipped with all necessary tools.',
    priceLabel: 'Rs. 500/hour',
    icon: Icons.water_drop_rounded,
    color:  Color(0xFF1A6FE0),
    lightColor:  Color(0xFFDCEAFD),
  ),
 const  ServiceModel(
    id: 'electrician',
    name: 'Electrician',
    description:
        'Expert electrical services including wiring, circuit breaker repair, fan & light installation, socket replacement, and electrical safety inspections. Licensed & insured professionals.',
    priceLabel: 'Rs. 600/hour',
    icon: Icons.electrical_services_rounded,
    color: Color(0xFFF59E0B),
    lightColor:  Color(0xFFFEF3C7),
  ),
  const ServiceModel(
    id: 'cleaner',
    name: 'Cleaner',
    description:
        'Thorough home and office cleaning services including deep cleaning, post-renovation cleanup, carpet washing, kitchen degreasing, and regular maintenance packages.',
    priceLabel: 'Rs. 400/hour',
    icon: Icons.cleaning_services_rounded,
    color:  Color(0xFF10B981),
    lightColor:  Color(0xFFD1FAE5),
  ),
 const  ServiceModel(
    id: 'painter',
    name: 'Painter',
    description:
        'Interior and exterior painting with premium quality paints. Services include wall preparation, crack filling, texture work, waterproofing, and decorative finishes.',
    priceLabel: 'Rs. 450/hour',
    icon: Icons.format_paint_rounded,
    color:  Color(0xFF8B5CF6),
    lightColor:  Color(0xFFEDE9FE),
  ),
  const ServiceModel(
    id: 'carpenter',
    name: 'Carpenter',
    description:
        'Skilled carpentry for furniture repair, custom woodwork, door & window fitting, cabinet installation, false ceiling work, and wooden flooring solutions.',
    priceLabel: 'Rs. 550/hour',
    icon: Icons.handyman_rounded,
    color:  Color(0xFFEF4444),
    lightColor:  Color(0xFFFEE2E2),
  ),
  const ServiceModel(
    id: 'ac_repair',
    name: 'AC Repair',
    description:
        'AC servicing, gas charging, coil cleaning, installation of split and window ACs, thermostat repair, and preventive maintenance to keep your AC running efficiently.',
    priceLabel: 'Rs. 800/hour',
    icon: Icons.ac_unit_rounded,
    color:  Color(0xFF06B6D4),
    lightColor:  Color(0xFFCFFAFE),
  ),
];