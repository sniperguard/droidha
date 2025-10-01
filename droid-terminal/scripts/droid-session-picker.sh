#!/bin/bash
# Interactive session picker for Droid Terminal

clear
echo "╔════════════════════════════════════════════════════════╗"
echo "║          Welcome to Droid Terminal                    ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""
echo "Select an option:"
echo ""
echo "  1) Start Droid CLI (new session)"
echo "  2) Resume existing Droid session"
echo "  3) Open bash shell"
echo "  4) View Droid help"
echo ""
echo -n "Enter your choice [1-4]: "

read -r choice

case $choice in
    1)
        echo ""
        echo "Starting Droid CLI..."
        sleep 1
        exec droid
        ;;
    2)
        echo ""
        echo "Resuming Droid session..."
        sleep 1
        exec droid --resume
        ;;
    3)
        echo ""
        echo "Starting bash shell..."
        echo "Type 'droid' to launch Droid CLI"
        sleep 1
        exec bash
        ;;
    4)
        echo ""
        droid --help
        echo ""
        echo "Press Enter to continue..."
        read -r
        exec "$0"
        ;;
    *)
        echo ""
        echo "Invalid choice. Starting Droid CLI..."
        sleep 2
        exec droid
        ;;
esac
