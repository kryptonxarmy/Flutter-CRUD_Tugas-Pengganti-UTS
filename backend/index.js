// index.js

const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();
const app = express();

app.use(bodyParser.json());
app.use(cors());

const PORT = process.env.PORT || 3000;

app.post("/items", async (req, res) => {
  const { name, category, description, price } = req.body;
  try {
    const item = await prisma.item.create({
      data: {
        name,
        category,
        description,
        price,
      },
    });
    res.json(item);
  } catch (error) {
    res.status(500).json({ error: "Failed to create item: " + error.message });
  }
});

app.get("/items", async (req, res) => {
  const items = await prisma.item.findMany();
  res.json(items);
});

app.get("/items/:id", async (req, res) => {
  const { id } = req.params;
  const item = await prisma.item.findUnique({
    where: { id: parseInt(id) },
  });
  if (item) {
    res.json(item);
  } else {
    res.status(404).json({ error: "Item not found" });
  }
});

// Update Item
app.put("/items/:id", async (req, res) => {
  const { id } = req.params;
  const { name, category, description, price } = req.body;
  try {
    const item = await prisma.item.update({
      where: { id: parseInt(id) },
      data: {
        name,
        category,
        description,
        price,
      },
    });
    res.json(item);
  } catch (error) {
    res.status(500).json({ error: "Failed to update item: " + error.message });
  }
});

app.delete("/items/:id", async (req, res) => {
  const { id } = req.params;
  try {
    await prisma.item.delete({
      where: { id: parseInt(id) },
    });
    res.json({ message: "Item deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: "Failed to delete item: " + error.message });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
