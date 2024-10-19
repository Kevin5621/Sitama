import 'package:flutter/material.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';

// Widget untuk menampilkan kartu informasi mahasiswa dengan dukungan aksi 
// tap dan long press. Termasuk dalam tampilan: gambar profil, nama, jurusan, 
// NIM, serta indikator pemilihan saat mode seleksi aktif.

class StudentCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String name;
  final String jurusan;
  final String nim;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const StudentCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.jurusan,
    required this.nim,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        elevation: 1, 
        color: AppColors.white, 
        child: Padding(
          padding: const EdgeInsets.all(16.0), 
          child: Row(
            children: [
              // Container untuk gambar profil yang ditampilkan dalam lingkaran
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
//vinsen.beta
                  color: isSelected
                      ? AppColors.info.withOpacity(0.1)
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
//vinsen.beta
                  ),
                ),
              ),
              const SizedBox(width: 16), 
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                        Text(
                          jurusan,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.gray,
                          ),
                        ),
                        Text(
                          nim,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Icon(Icons.check_circle, color: Colors.blue),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
