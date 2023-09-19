const Student = require('../models/student');
const getQuery = require('../utils/getQuery');
const getBody = require('../utils/getBody');
const getSearchQuery = require('../utils/getSearchQuery');

const index = async (req, res) => {
  try {
    const { student, subject, type, limit, skip } = getQuery(req.query);
    const { id } = req.params;

    const searchQuery = getSearchQuery({ student, subject, type, id });

    const found = await Student.find(searchQuery)
      .sort({ student: 1, subject: 1, type: 1 })
      .limit(limit)
      .skip(skip)
      .catch((err) => {
        throw new Error(err);
      });

    res.json({ count: found.length, docs: found, limit, skip });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

const store = async (req, res) => {
  try {
    const body = getBody(req.body);

    const newStudentGrade = await Student.create(body).catch((err) => {
      throw new Error(err);
    });

    res.status(201).json(newStudentGrade);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

const update = async (req, res) => {
  try {
    const { id } = req.params;
    const { limit, skip } = getQuery(req.query);
    const body = getBody(req.body);

    const found = await Student.findOneAndUpdate({ _id: id }, { $set: body }, { new: true }).catch(
      (err) => {
        throw new Error(err);
      },
    );

    res.json({ count: [found].length, docs: [found], limit, skip });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

const destroy = async (req, res) => {
  try {
    const { id } = req.params;

    const found = await Student.findOneAndUpdate(
      { _id: id },
      { isActive: false },
      { new: true },
    ).catch((err) => {
      throw new Error(err);
    });

    res.status(204).end();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = { index, store, update, destroy };
