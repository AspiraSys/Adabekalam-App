
import 'package:cloud_firestore/cloud_firestore.dart';

void addMultipleDummyData() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> dummyData = [
    {
      "id": "UtKgPzKzA3oT7A0c4NZS",
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "author": "Skye Applebome",
      "category": "Romantic",
      "language": "English",
      "image": "https://i.pinimg.com/736x/57/84/12/578412945d34fea6b8801fa6ee622f33.jpg",
      "likes": [],
      "title": "Beautiful, Cruel World",
      "paragraph": "Beneath the moon’s soft silver light, I wait for you in endless night. The stars whisper your name so sweet, Yet fate keeps us just out of reach. A touch unseen, a love so true, My heart still beats—just for you. If time should break, if stars should fall, I'd find you, love, beyond them all."
    },
    {
      "id": "Xyz123Mystery001",
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "author": "James Everett",
      "category": "Mysterious",
      "language": "English",
      "image": "https://i.pinimg.com/736x/22/33/45/2233456789a2e5e6a8801fb6ff633b22.jpg",
      "likes": [],
      "title": "The Silent Echo",
      "paragraph": "Shadows danced along the quiet alley, whispers of secrets long buried in the cobbled streets. A figure emerged from the mist, cloaked in darkness, holding an object that glowed faintly. Who was he? What did he carry? The city’s oldest mystery was about to unfold."
    },
    {
      "id": "TamRom1234",
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "author": "அரவிந்த் குமார்",
      "category": "Romantic",
      "language": "Tamil",
      "image": "https://i.pinimg.com/736x/99/88/77/99887766d44b3a2b3f554b2c2ff09933.jpg",
      "likes": [],
      "title": "நிலா இரவுகள்",
      "paragraph": "நிலாவின் வெளிச்சத்தில், உன் நினைவுகளுடன் நான் உறங்கினேன். உன் பார்வை என் கனவுகளின் பாலம். உன் மென்மையான தொட்டு, என் இதயத்தைக் கனிந்து விடும். இந்த உலகம் மாறினாலும், உன் மீது என் காதல் எப்போதும் மாறாது."
    },
    {
      "id": "UrduLove987",
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "author": "عمران رشید",
      "category": "Romantic",
      "language": "Urdu",
      "image": "https://i.pinimg.com/736x/11/22/33/112233445566778899.jpg",
      "likes": [],
      "title": "محبت کی رات",
      "paragraph": "چاندنی راتوں میں تیرا انتظار رہا، ہر لمحہ تجھ سے پیار رہا۔ تیری یادوں کی روشنی میں میں نے اپنی زندگی گزاری، تیری محبت میری دنیا کا سب سے خوبصورت خواب ہے، جو کبھی حقیقت میں بدل جائے تو دنیا کا سب سے حسین لمحہ ہوگا۔"
    },
    {
      "id": "HappyDay567",
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "author": "Lena Crowley",
      "category": "Happy",
      "language": "English",
      "image": "https://i.pinimg.com/736x/44/55/66/445566778899aabbcc.jpg",
      "likes": [],
      "title": "A Day of Joy",
      "paragraph": "Sunshine filled the sky, laughter echoed in the streets. Children ran with balloons, their faces glowing with joy. It was a day untouched by worries, where every heart danced in pure happiness, where smiles were endless and love was all around."
    },
    {
      "id": "TamHappy007",
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "author": "மோகன் வெங்கட்",
      "category": "Happy",
      "language": "Tamil",
      "image": "https://i.pinimg.com/736x/77/88/99/778899aa1122b3c3.jpg",
      "likes": [],
      "title": "பயணத்தின் மகிழ்ச்சி",
      "paragraph": "படகில் பயணித்தோம், உள்ளத்தோடு ஆனந்தமாக. கடலின் சப்தம், காற்றின் மென்மை, எல்லாம் ஒரே கணத்தில் சேர்ந்து நம் வாழ்க்கையை நிறைவு செய்யும் போலிருந்தது. இந்த மகிழ்ச்சி என்றும் நினைவில் இருக்கும்."
    },
    {
      "id": "UrduHappy123",
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "author": "فرحان احمد",
      "category": "Happy",
      "language": "Urdu",
      "image": "https://i.pinimg.com/736x/00/11/22/001122334455667788.jpg",
      "likes": [],
      "title": "خوشیوں کا جہاں",
      "paragraph": "بچوں کی ہنسی، رنگ برنگے غبارے، خوشیوں کا میلہ ہر طرف سجا ہوا تھا۔ یہ وہ لمحہ تھا جہاں ہر دل خوش تھا، ہر آنکھ میں چمک تھی، ہر لب پر ہنسی تھی۔ خوشیوں کا یہ جہاں ہمیشہ کے لیے دل میں بسا رہے گا۔"
    },
    {
      "id": "PeacefulDay987",
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "author": "Hugo Fernandez",
      "category": "Peaceful",
      "language": "English",
      "image": "https://i.pinimg.com/736x/33/44/55/33445566778899aabb.jpg",
      "likes": [],
      "title": "Calm Waters",
      "paragraph": "Waves gently kissed the shore as the world drifted into harmony. The soft rustle of leaves, the distant hum of birds, and the warmth of the setting sun brought a peace beyond words. It was a moment where the universe whispered, 'You are home.'"
    }
 
 
  ];

  for (var doc in dummyData) {
    await firestore.collection("feeds").doc(doc["id"]).set(doc);
  }
}

