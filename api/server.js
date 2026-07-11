const express = require("express");
const mongoose = require("mongoose");

const app = express();

app.use(express.json());

const PORT = process.env.PORT || 3000;

// Connect to MongoDB
mongoose
    .connect(process.env.MONGO_URI)
    .then(() => {
        console.log("✅ Connected to MongoDB");
    })
    .catch((err) => {
        console.error("❌ MongoDB Connection Error:", err);
    });

// Todo Schema
const todoSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    completed: {
        type: Boolean,
        default: false
    }
});

// Todo Model
const Todo = mongoose.model("Todo", todoSchema);

// Home Route
app.get("/", (req, res) => {
    res.send("Hello from Todo API");
});

// Get All Todos
app.get("/todos", async (req, res) => {
    try {
        const todos = await Todo.find();
        res.json(todos);
    } catch (err) {
        res.status(500).json({
            message: err.message
        });
    }
});

// Get Todo By ID
app.get("/todos/:id", async (req, res) => {
    try {
        const todo = await Todo.findById(req.params.id);

        if (!todo) {
            return res.status(404).json({
                message: "Todo not found"
            });
        }

        res.json(todo);

    } catch (err) {
        res.status(500).json({
            message: err.message
        });
    }
});

// Create Todo
app.post("/todos", async (req, res) => {
    try {
        const todo = await Todo.create({
            title: req.body.title
        });

        res.status(201).json(todo);

    } catch (err) {
        res.status(500).json({
            message: err.message
        });
    }
});

// Update Todo
app.put("/todos/:id", async (req, res) => {
    try {
        const todo = await Todo.findByIdAndUpdate(
            req.params.id,
            req.body,
            {
                new: true,
                runValidators: true
            }
        );

        if (!todo) {
            return res.status(404).json({
                message: "Todo not found"
            });
        }

        res.json(todo);

    } catch (err) {
        res.status(500).json({
            message: err.message
        });
    }
});

// Delete Todo
app.delete("/todos/:id", async (req, res) => {
    try {
        const todo = await Todo.findByIdAndDelete(req.params.id);

        if (!todo) {
            return res.status(404).json({
                message: "Todo not found"
            });
        }

        res.json({
            message: "Todo deleted successfully",
            deletedTodo: todo
        });

    } catch (err) {
        res.status(500).json({
            message: err.message
        });
    }
});

// Start Server
app.listen(PORT, () => {
    console.log(`🚀 Server is running on port ${PORT}`);
});
