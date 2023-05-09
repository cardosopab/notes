import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/note.dart';

class NoteNotifier extends StateNotifier<List<Note>> {
  late final SharedPreferences _prefs;
  NoteNotifier(List<Note> notes) : super(notes) {
    _loadNotes();
  }

  void addNote(Note note) {
    state = [...state, note];
    _saveNotes();
  }

  void deleteNote(String noteId) {
    state = [
      for (final note in state)
        if (note.id != noteId) note,
    ];
    _saveNotes();
  }

  void reorderNotesByTitle() {
    state.sort((a, b) => a.title.compareTo(b.title));
    state = state.toList();
    _saveNotes();
  }

  void reorderNotesByDate() {
    state.sort((a, b) => a.date.compareTo(b.date));
    state = state.toList();
    _saveNotes();
  }

  void reorderNotesByBody() {
    state.sort((a, b) => a.body.compareTo(b.body));
    state = state.toList();
    _saveNotes();
  }

  void updateNote(Note newNote, String noteId) {
    state = state.map((note) {
      return note.id == noteId ? newNote : note;
    }).toList();
    _saveNotes();
  }

  static const _kNotesKey = 'notes';

  Future<void> _saveNotes() async {
    final notesJson = jsonEncode(state.map((note) => note.toJson()).toList());
    _prefs.setString(_kNotesKey, notesJson);
  }

  Future<void> _loadNotes() async {
    _prefs = await SharedPreferences.getInstance();
    final notesJson = _prefs.getString(_kNotesKey);
    if (notesJson != null) {
      final notesData = jsonDecode(notesJson) as List<dynamic>;
      final notes = notesData.map((data) => Note.fromJson(data)).toList();
      state = notes;
    }
  }
}

final noteStateNotifierProvider = StateNotifierProvider<NoteNotifier, List<Note>>((ref) {
  return NoteNotifier([]);
});
